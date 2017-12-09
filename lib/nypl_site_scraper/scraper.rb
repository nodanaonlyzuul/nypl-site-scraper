require 'mechanize'

module NyplSiteScraper
  class Client

    attr_reader :pin, :barcode, :homepage

    def initialize(options = {barcode: nil, })
      @barcode = options[:barcode]
      @pin     = options[:pin]
      @agent   = Mechanize.new
    end

    def login!
      login_page = @agent.get('https://catalog.nypl.org/iii/cas/login?service=https%3A%2F%2Fcatalog.nypl.org%3A443%2Fpatroninfo~S1%2FIIITICKET&scope=1')
      form = login_page.form
      form.code = barcode
      form.pin = pin
      @homepage = @agent.submit(form, form.buttons.first)
      true
    end

    def get_fines
      @fines_page ||= @agent.get("https://catalog.nypl.org/patroninfo~S1/thisurlsegment-doesnt-seem-to-matter-hahahah/overdues")
      fines_rows = @fines_page.search('tr.patFuncFinesEntryTitle')

      fines_response = []
      fines_rows.each_with_index do |overdue_row, index|
        fines_response << {
          title: overdue_row.text.strip,
          fineAmount: @fines_page.search('td.patFuncFinesDetailAmt')[index].text.strip
        }
      end

      {fines: fines_response}
    end

    def get_holds
      @holds_page ||= @homepage.link_with(text: "My Holds").click
      holds_rows = @holds_page.css('tr.patFuncEntry')

      response_holds = []

      holds_rows.each do |hold_row|
        status_string = hold_row.css('td.patFuncStatus').text.strip
        response_holds << {
          title:          hold_row.css('td.patFuncTitle').text.strip,
          statusString:   status_string,
          status:         map_status_string(status_string),
          pickupLocation: get_pickup_location(hold_row),
       }
     end

     {holds: response_holds}
   end

   private

   def map_status_string(status_string)

  if status_string == "READY FOR PICKUP"
    return "ready"
  elsif status_string == "IN TRANSIT"
    return "in transit"
  elsif status_string.include?('of')
    return "pending"
  else
    return status_string
  end
end

# Helper because markup for pending vs ready is different
def get_pickup_location(row)
  pickUpCell = row.css('td.patFuncPickup')
  if pickUpCell.search('div.patFuncPickupLabel').length > 0
    row.css('td.patFuncPickup option[selected=selected]').first.text.strip
    # pickUpCell.search('div.patFuncPickupLabel').text.strip
  else
    pickUpCell.text.strip
  end
end

  end

end

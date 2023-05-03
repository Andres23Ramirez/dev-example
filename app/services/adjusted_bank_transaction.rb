class AdjustedBankTransaction
  require 'csv'

  def initialize(file, filename)
    @file = file
    @filename = filename
  end

  def call
    file_contents = read_file_contents
    total = file_contents.delete_at(-1)
    amount = calculate_amount(file_contents)

    file_contents << "mechanincal business transoformation GCP - consolidated,#{amount}"
    file_contents << "mechanincal business transoformation GCP - consolidated,#{amount * -1}"
    file_contents << "Total,#{total}"

    validate_total(total, amount)

    write_output_file(file_contents)

    file_contents.to_json
  rescue StandardError => e
    { error: "Error processing file: #{e.message}" }.to_json
  end

  private

  def read_file_contents
    @file.readlines.map(&:chomp)
  end

  def calculate_amount(file_contents)
    amount = 0
    file_contents.each do |element|
      if element.include?("GCP")
        match = element.match(/^(.*?)(\d+[,.]\d+)$/)
        description = match[1].strip
        amount += match[2].gsub(',', '').to_f
      end
    end
    amount
  end

  def validate_total(total, amount)
    raise "Total sum does not match calculated amount" unless total.to_f == (amount * 2).round(2)
  end

  def write_output_file(file_contents)
    CSV.open("received_files/adjusted_#{@filename}.csv", "wb") do |csv|
      file_contents.each do |row|
        csv << row.split("\n")
      end
    end
  end
end

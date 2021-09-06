require 'csv'
require 'erb'
require 'time'
require 'date'
require 'google/apis/civicinfo_v2'
puts 'EventManager Initialized!'

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
    rescue
      'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
    end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0').slice(0, 4)
end

def clean_phone_number(phone_number)
  no_symbols = cut_extra_symbols(phone_number)
  if no_symbols.length == 11 && no_symbols[0] == '1'
    no_symbols = no_symbols[1..no_symbols.length - 1]
  elsif no_symbols.length == 11
    no_symbols = ''
  elsif no_symbols.length < 10 || no_symbols.length > 11
    no_symbols = ''
  end
  add_dashes(no_symbols)
end

def add_dashes(phone_number)
  return if phone_number == ''
  
  phone_number.insert(3, '-')
  phone_number.insert(7, '-')
end

def cut_extra_symbols(phone_number)
  clean_num = ''
  phone_number.each_char do |c|
    clean_num += c unless c.to_i.zero? && c != '0'
  end
  clean_num
end

hours = Hash.new(0)
days = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  # zipcode = clean_zipcode(row[:zipcode])
  # legislators = legislators_by_zipcode(zipcode)
  # form_letter = erb_template.result(binding)
  # save_thank_you_letter(id, form_letter)
  phone_number = clean_phone_number(row[:homephone])
  date = Time.strptime(row[:regdate], "%m/%d/%y %k:%M")
  date_no_time = DateTime.strptime(row[:regdate], "%m/%d/%y %k:%M")
  hours[date.hour] += 1
  days[date_no_time.wday] += 1
  puts "Name: #{name} Phone: #{phone_number} Date: #{date}"
end

p hours
p days

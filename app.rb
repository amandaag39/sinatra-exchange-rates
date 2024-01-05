require "sinatra"
require "sinatra/reloader"
require "http"


get("/") do
   # build the API url, including the API key in the query string
   api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATES_KEY"]}"

   # use HTTP.get to retrieve the API information
   raw_data = HTTP.get(api_url)

   # convert the raw request to a string
   raw_data_string = raw_data.to_s

   # convert the string to JSON
   parsed_data = JSON.parse(raw_data_string)

   # get the symbols from the JSON
   @symbols = parsed_data.fetch("currencies")
  erb(:homepage)
end

get("/:initial_currency") do
  @initial_currency = params.fetch("initial_currency")

  # build the API url, including the API key in the query string
  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATES_KEY"]}"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)

  # get the symbols from the JSON
  @symbols = parsed_data.fetch("currencies")


  erb(:initial_currency_landing)
end

get("/:initial_currency/:converted_currency") do
  @initial_currency = params.fetch("initial_currency")
  @converted_currency = params.fetch("converted_currency")

  api_url = "http://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATES_KEY"]}&from=#{@initial_currency}&to=#{@converted_currency}&amount=1"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)

  @result = parsed_data.fetch("result")

  erb(:converted_currency_landing)  
end

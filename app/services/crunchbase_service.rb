require 'net/http'

class CrunchbaseService
  attr_reader :base_url

  COMPANIES_PATH = "/api/crunchbase_companies".freeze
  ROUNDS_PATH = "/api/crunchbase_rounds"
  INVESTMENTS_PATH = "/api/crunchbase_investments"

  def initialize(base_url: ENV["CRUNCHBASE_URL"])
    @base_url = base_url
  end

  def find_companies
    page = 1

    loop do
      response = Net::HTTP.get_response(uri(path: COMPANIES_PATH, page: page))
      raise "Error communicating with Crunchbase API" unless response.is_a? Net::HTTPSuccess

      dataset = JSON.parse(response.body)
      count = dataset["crunchbase_companies"]&.length || 0
      break if count.zero?

      dataset["crunchbase_companies"].each { |company| yield company }
      page += 1
    end
  end

  def find_company_rounds(permalink)
    page = 1

    loop do
      response_body = Rails.cache.fetch("#{ROUNDS_PATH}/#{page}", expires_in: 6.hours) do
        response = Net::HTTP.get_response(uri(path: ROUNDS_PATH, page: page))
        raise "Error communicating with Crunchbase API" unless response.is_a? Net::HTTPSuccess
        response.body
      end

      dataset = JSON.parse(response_body)
      count = dataset["rounds"]&.length || 0
      break if count.zero?

      dataset["rounds"].each { |round| yield round if round["company_permalink"] == permalink }
      page += 1
    end
  end

  private

  def uri(path:, page: 1)
    URI("#{base_url}#{path}").tap do |u|
      u.query = URI.encode_www_form({ page: page })
    end
  end
end

require "net/https"
require "uri"
module Netbilling
  class Payment

    PAY_TYPE = 'C' # we are only accepting credit cards
    ACCOUNT_ID = ENV['NB_ACCOUNT_ID']
    DYNIP_SEC_CODE = ENV['NB_DYNIP_SEC_CODE']
    SSL_URL = "https://secure.netbilling.com:1402/gw/sas/"
    TRANS_ID_URL = "getid3.2"
    BILLING_URL = "direct3.2"
    SITE_TAG = 'HD'
    PLAN_PRICE = 39.95
    MEMBERSHIP_DURATION = 30
    USER_AGENT = 'SearchSingles/Version:2013.Jun.30'

    attr_reader :payment_data, :username, :response,
                :transaction_id, :membership_id, :params

    class PaymentError < StandardError; end
    class AuthorizationError < StandardError; end

    def initialize(payment_data, username)
      @payment_data = payment_data
      @username = username
      @params = {}
      ids = new_id(2)
      @membership_id = ids[0]
      @transaction_id = ids[1]
    end

    def authorize!
      fill_params('A')
      resp = post_response
      @response = parse_response(resp.body)
      log_response(resp)
      unless resp.status.to_i == 200
        raise PaymentError, 'Error Happened'
      end
    end

    def process!
      fill_params('S')
      resp = post_response
      # log the resp.body here
      @response = parse_response(resp.body)
      log_response(resp)
      unless resp.code.to_i == 200
        raise PaymentError, 'Error Happened'
      end
    end

    private
    def log_response(resp)
      PaymentsLogger.create!(user_id: username,
                             message: resp.inspect,
                             body: resp.body.inspect)
    end
    def parse_response(string)
      string.split('&').inject({}) { |hash, v| hash.merge(v.split('=')[0] => v.split('=')[1]) }
    end
    def post_response
      uri = URI.parse(SSL_URL + BILLING_URL)

      # Full control
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(params)
      request['User-Agent'] = USER_AGENT

      response = http.request(request)
    end

    def fill_site_info
      params[:pay_type] = PAY_TYPE
      params[:account_id] = ACCOUNT_ID
      params[:trans_id] = transaction_id
      params[:dynip_sec_code] = DYNIP_SEC_CODE
      params[:amount] = PLAN_PRICE
    end

    def fill_params(tran_type)
      params[:tran_type] = tran_type
      fill_site_info
      fill_card_info
      fill_customer_info
      fill_membership_info
    end

    def new_id(size = 1)
      resp = HTTParty.get(SSL_URL + TRANS_ID_URL + "?#{size}",
                          headers: { 'User-Agent' => USER_AGENT })
      resp.chomp.split("\n") if resp.present?
    end

    def fill_card_info
      params[:card_number] = payment_data.credit_card_number
      params[:card_expire] = payment_data.card_expire
      params[:card_cvv2] = payment_data.security_code
    end

    def fill_customer_info
      params[:bill_name1] = payment_data.first_name
      params[:bill_name2] = payment_data.last_name
      params[:bill_street] = payment_data.address
      params[:bill_zip] = payment_data.zip_code
      params[:bill_country] = payment_data.country_code.upcase
      params[:cust_email] = payment_data.email
    end

    def fill_membership_info
      params[:site_tag] = SITE_TAG
      params[:member_username] = username
      params[:member_duration] = 30
      params[:member_id] = membership_id
      params[:recurring_period] = "add_months((trunc(sysdate)+0.5),1)"
      params[:recurring_amount] = PLAN_PRICE
    end
  end
end


class WebpayPlusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initialize
    super
    logger.info "-----------------------------------------------------------" 
    logger.info ::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS
    logger.info ::Transbank::Common::IntegrationApiKeys::WEBPAY.inspect
    logger.info "-----------------------------------------------------------"
    wp_base_uri=                 "https://webpay3g.transbank.cl"
    wp_comercio=                 ENV["WEBPAY_CODIGO_COMERCIO"].to_s
    wp_shared_secret=            ENV["WEBPAY_SHARED_SECRET"].to_s
    wp_api_key=                  ENV["WEBPAY_API_KEY"].to_s 
    wp_return_url=               "ttps://api.alectrico.cl/return_url"

    @tx = Transbank::Webpay::WebpayPlus::Transaction.new(::Transbank::Common::IntegrationCommerceCodes::WEBPAY_PLUS, ::Transbank::Common::IntegrationApiKeys::WEBPAY, :integration)
    @ctrl = "webpay_plus"
  end

  def create

    @req = params.as_json
    @buy_order = "buyOrder_#{rand(1000)}"
    @session_id = "sessionId_#{rand(1000)}"
    @amount = 1000
    @return_url = "#{root_url}#{@ctrl}/commit"
    @resp = @tx.create(@buy_order, @session_id, @amount, @return_url)
  end

  def commit
    @req = params.as_json
    @token = params[:token_ws]
    @resp = @tx.commit(@token)
    
  end

  def refund
    @req = params.as_json
    @token = params[:token]
    @amount = params[:amount]
    @resp = @tx.refund(@token, @amount)
    redirect_to webpay_plus_refund_path(token: @token, amount: @amount, resp: @resp)
  end

  def show_refund
    @token = params[:token]
    @amount = params[:amount]
    @resp = params[:resp]
  end

  def status
    @req = params.as_json
    @token = params[:token]
    @resp = @tx.status(@token)
    
  end

end

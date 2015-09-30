class DealCategoriesController < ApplicationController

  after_action :log_errors, only: %i(index show), if: ->() { @deals.has_errors? }

  def index
    @deals = LocalDeal.order(:score).page(1).per(15)
  end

  def show
    @parameters = params.slice(:id, :local_deals, :page, :controller, :action).reject { |_k, v| v.blank? }
    current_page = @parameters.key?(:page) ? @parameters[:page].to_i : 1
    @deals = LocalDeal.where(category: @parameters[:id]).order(:score).page(current_page).per(30)
    if @parameters.key?(:local_deals) && @parameters[:local_deals][:market].present?
      @parameters[:local_deals][:market].downcase!
      @deals.where(market: @parameters[:local_deals][:market])
    end
  end

  private

  def log_errors
    @deals.errors.each { |error| Rails.logger.warn "XAPIX error: '#{error.status} - #{error.title}'" }
  end
end

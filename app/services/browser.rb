# frozen_string_literal: true

class Browser
  RETRY_INTERVAL = 0.03
  TIMEOUT = 5
  FORMATS = %w[Document Script XHR].freeze

  class NotFoundError < StandardError; end

  def visit(url:, tag:)
    browser.network.intercept
    browser.on(:request) { |request| FORMATS.include?(request.resource_type) ? request.continue : request.abort }
    browser.go_to(url)
    wait_for_element(tag)
    clear_cache

    browser.body
  end

  def exit_browser
    browser.quit
  end

  private

  def browser
    @browser ||= Ferrum::Browser.new(pending_connection_errors: false, timeout: 30)
  end

  def wait_for_element(tag)
    load_time = 0
    begin
      raise NotFoundError if browser.at_css(tag).nil?
    rescue NotFoundError, Ferrum::NodeNotFoundError
      sleep RETRY_INTERVAL
      clear_cache
      load_time += RETRY_INTERVAL
      retry if load_time <= TIMEOUT
    end
  end

  def clear_cache
    browser.network.clear(:traffic)
    browser.network.clear(:cache)
    browser.cookies.clear
  end
end

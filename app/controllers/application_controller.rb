# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # URL生成用のグローバルなデフォルトパラメータを設定
  def default_url_options
    { locale: I18n.locale }
  end

  # paramsからロケールを取得する
  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end

# app/controllers/concerns/breadcrumbs.rb
module Breadcrumbs
  extend ActiveSupport::Concern

  included do
    before_action :initialize_breadcrumbs
    helper_method :add_breadcrumb, :render_breadcrumbs
  end

  def initialize_breadcrumbs
    @breadcrumbs = []
  end

  def add_breadcrumb(name, path = nil)
    @breadcrumbs << [name, path]
  end

  def render_breadcrumbs(separator: " / ")
    return if @breadcrumbs.blank?

    helpers.safe_join(@breadcrumbs.map.with_index do |(name, path), index|
      if path && index < @breadcrumbs.size - 1
        helpers.link_to(name, path, class: "text-blue-600 hover:underline")
      else
        helpers.content_tag(:span, name, class: "text-gray-500 font-medium")
      end
    end, separator.html_safe)
  end
end

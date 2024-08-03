# frozen_string_literal: true

module Spree
  module FrontendHelperDecorator
    def logo(image_path = nil, options = {})
      logo_attachment = if defined?(Spree::StoreLogo) && current_store.logo.is_a?(Spree::StoreLogo)
                          current_store.logo.attachment # Spree v5
                        else
                          current_store.logo # Spree 4.x
                        end

      image_path ||= if logo_attachment&.attached? && logo_attachment&.variable?
                       main_app.cdn_image_url(logo_attachment.variant(resize_to_limit: [244, 104]))
                     elsif logo_attachment&.attached? && logo_attachment&.image?
                       main_app.cdn_image_url(logo_attachment)
                     else
                       asset_path('logo/spree_50.png')
                     end

      path = spree.respond_to?(:root_path) ? spree.root_path : main_app.root_path

      link_to path, 'aria-label': current_store.name, method: options[:method] do
        image_tag image_path, alt: current_store.name, title: current_store.name
      end
    end
  end

  FrontendHelper.prepend(Spree::FrontendHelperDecorator)
end

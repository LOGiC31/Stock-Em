# frozen_string_literal: true

# Items utility methods
module ItemsHelper
  def icon_for_category(category) # rubocop:disable Metrics/MethodLength
    case category
    when 'Mobile Devices'
      'fa-mobile-alt'
    when 'Development Boards and Kits'
      'fa-regular fa-layer-group'
    when 'Sensors and Modules'
      'fa-solid fa-fingerprint'
    when 'Computer Accessories'
      'fa-solid fa-ethernet'
    when 'Displays'
      'fa-solid fa-desktop'
    when 'Furnitures'
      'fa-chair'
    else
      'fa-regular fa-layer-group'
    end
  end
end

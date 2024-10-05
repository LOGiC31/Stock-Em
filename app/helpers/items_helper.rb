# frozen_string_literal: true

# Items utility methods
module ItemsHelper
  def icon_for_category(category)
    case category
    when 'Electronics'
      'fa-mobile-alt'
    when 'Furniture'
      'fa-chair'
    else
      'fa-box'
    end
  end
end

module ItemsHelper
    def icon_for_category(category)
      case category
      when 'Electronics'
        'fa-mobile-alt' # Mobile icon for electronics
      when 'Furniture'
        'fa-chair' # Chair icon for furniture
      else
        'fa-box' # Default icon
      end
    end
  end
  
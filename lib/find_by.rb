
class Module
  def create_finder_methods(*attributes)
    attributes.each do |attribute|
      method = %Q{
        def self.find_by_#{attribute}(filter)
          all.find { |item| item.#{attribute} == filter }
        end
      }

      class_eval(method)
    end
  end
end

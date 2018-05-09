class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true



end
#
# module ComparableDates
#
#   def is_after_customer_registration?
#   end
# end

# class Date
#   def is_after(other)
#     raise if !other.is_a?(Date) && !other.is_a?(DateTime)
#     return self < other
#   end
# end

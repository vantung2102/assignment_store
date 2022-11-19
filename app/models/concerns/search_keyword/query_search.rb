module SearchKeyword
  module QuerySearch
    extend ActiveSupport::Concern

    def ApplicationRecord.query_search(attributes, parameter)
      if attributes.is_a?(Array)
        query = attributes.map { |attr| "MATCH (#{attr}) AGAINST ('#{parameter}')" }.join('OR')
        where(query)
      else
        where("MATCH (#{attributes}) AGAINST ('#{parameter}')")
      end
    end
  end
end

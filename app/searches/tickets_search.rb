class TicketsSearch
  attr_reader :query, :fields, :default_operator

  def initialize(query)
    @query = query
    @fields = [:uid, :summary, :body]
    @default_operator = 'or'
  end

  def search
    query_string = { fields: fields, query: query,
                     default_operator: default_operator }
    TicketsIndex.query(query_string: query_string) # .load
  end
end

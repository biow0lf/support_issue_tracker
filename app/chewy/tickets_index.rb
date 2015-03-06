class TicketsIndex < Chewy::Index
  define_type Ticket do
    field :uid
    field :summary
    field :body
  end
end

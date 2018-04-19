class User < ApplicationRecord
  #Team : common, groove, amanda-server(+QA), amanda-client, groove, ceo
  as_enum :team, common: 0, groove: 1, amanda_server_QA:2, amanda_client:3 , ceo:4
  belongs_to :jo
end

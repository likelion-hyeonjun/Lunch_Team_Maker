class User < ApplicationRecord
  as_enum :team, common: 0, groove: 1, amanda_server:2, ceo: 3
end

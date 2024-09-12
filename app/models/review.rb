class Review < ApplicationRecord
  belongs_to :city
  belongs_to :user # Associa una recensione a un utente

end

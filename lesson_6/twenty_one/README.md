# Twenty-One

### Design Notes:
* Each `Player` (excluding `Dealer`) is added to a `Players` array
* Each `Player` (including `Dealer`) is a hash with the following key/value pairs:
  * `:name =>` unique string to identify the player
  * `:hand =>` nested array containing each card array in the player's hand
  * `:total =>` integer representing the value of the player's hand
  * `:busted =>` boolean representing whether or not the player has busted
  * `:match_score =>` integer representing the total wins the player has accumulated in the current match

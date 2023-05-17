class AddUsernameToTweets < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :tweets, :username
  end
end

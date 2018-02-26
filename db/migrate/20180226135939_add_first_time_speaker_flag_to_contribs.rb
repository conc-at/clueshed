class AddFirstTimeSpeakerFlagToContribs < ActiveRecord::Migration[5.1]
  def change
    add_column :contribs, :first_time_speaker, :boolean, default: false
  end
end

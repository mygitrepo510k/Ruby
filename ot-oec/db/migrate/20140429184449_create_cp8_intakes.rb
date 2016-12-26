class CreateCp8Intakes < ActiveRecord::Migration
  def change
    create_table :cp8_intakes do |t|
      t.references :users, index: true
      t.text :birthdate
      t.text :live
      t.text :book_stranger
      t.text :stranger_adventure
      t.text :desires
      t.text :top_desires
      t.text :top_fears
      t.text :kidness
      t.text :phobias
      t.text :therapist
      t.integer :sex_life
      t.integer :purpose
      t.integer :emotional
      t.integer :honesty
      t.integer :love
      t.integer :speaking
      t.integer :enjoy_challenge
      t.integer :trust
      t.integer :dark_side
      t.text :gain_trust
      t.text :young_old
      t.text :what_triggers
      t.text :trigger_response
      t.text :get_you_once_triggered
      t.text :food
      t.text :color
      t.text :movie
      t.text :song
      t.text :law
      t.text :dream
      t.text :knowledgable
      t.text :edges
      t.text :hard_nos
      t.text :people_adversion
      t.text :people_trust
      t.text :bring_to_game
      t.text :anything_else

      t.timestamps
    end
  end
end

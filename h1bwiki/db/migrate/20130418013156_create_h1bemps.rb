class CreateH1bemps < ActiveRecord::Migration
  def change
    create_table :h1bemps do |t|
      t.string :employername
      t.string :empaddress
      t.string :empcity
      t.string :empstate
      t.string :empzip
      t.string :h1btotalapplied
      t.string :h1totaldenied
      t.string :h1bapprovalrate
      t.string :prevh1count
      t.string :gctotalapplied
      t.string :gctotaldenied
      t.string :gcapprovalrate
      t.string :prevgccount
      t.string :prevh1flag
      t.string :prevgcflag
      t.string :h1barateflag
      t.string :gcarateflag
      t.string :everifiedflag
      t.string :workforcesize

      t.timestamps
    end
  end
end

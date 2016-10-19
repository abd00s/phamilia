require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:nisreen) { Person.find_by(first_name: "Nisreen") } # Has all connections
  let(:dina) { Person.find_by(first_name: "Dina") } # Has no parents
  let(:gaith) { Person.find_by(first_name: "Gaith") } # Has no children, no siblings

  describe "#parent_in" do
    context "person is a parent in one active marriage" do
      it "returns the union in which person is a parent" do
        expect(dina.parent_in).to be_an(ActiveRecord::Relation)
        expect(dina.parent_in).to all be_a(Union)
        expect(dina.parent_in.count).to eq(1)
        expect(dina.parent_in.first.wife_id).to be(dina.id)
      end
    end

    context "person is not in any marriage" do
      it "returns an empty AR Relation" do
        expect(gaith.parent_in).to be_an(ActiveRecord::Relation)
        expect(gaith.parent_in.count).to eq(0)
      end
    end
  end
end

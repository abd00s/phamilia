require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:nisreen) { Person.find_by(first_name: "Nisreen") } # Has all connections
  let(:dina) { Person.find_by(first_name: "Dina") } # Has no parents
  let(:gaith) { Person.find_by(first_name: "Gaith") } # Has no children, no siblings
  let(:bassam) { Person.find_by(first_name: "Bassam") }
  let(:yasmin) { Person.find_by(first_name: "Yasmin") }

  describe "association #father" do
    context "person has a father in the network" do
      it "returns the Person object of the father" do
        expect(nisreen.father).to be_present
        expect(nisreen.father.id).to be(bassam.id)
      end
    end

    context "person's father is not defined in the network" do
      it "returns nil" do
        expect(dina.father).to_not be_present
        expect(dina.father).to be_nil
      end
    end
  end

  describe "association #mother" do
    context "person has mother in the network" do
      it "returns the Person object of the mother" do
        expect(nisreen.mother).to be_present
        expect(nisreen.mother.id).to be(dina.id)
      end
    end

    context "person's mother is not defined in the network" do
      it "returns nil" do
        expect(dina.mother).to_not be_present
        expect(dina.mother).to be_nil
      end
    end
  end

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

  describe "#children" do
    context "person has children from one marriage" do
      it "returns an array of person's children" do
        expect(nisreen.children).to be_an(Array)
        expect(nisreen.children).to all satisfy{|child| child.mother.id == nisreen.id}
        expect(nisreen.children.count).to be(1)
      end
    end

    context "person has no children" do
      it "returns an empty array" do
        expect(gaith.children).to_not be_present
        expect(gaith.children).to eq([])
      end
    end
  end

  describe "#spouse" do
    context "person is a female in an active marriage (and no previous marriages)" do
      it "returns person's husband" do
        expect(dina.spouse).to eq(bassam)
      end
    end

    context "person is a female with no husband in the network" do
      it "returns nil" do
        expect(yasmin.spouse).to_not be_present
        expect(yasmin.spouse).to be_nil
      end
    end

    context "person is a male in an active marriage (and no previous marriages)" do
      it "returns person's wife" do
        expect(bassam.spouse).to eq(dina)
      end
    end

    context "person is a male with no husband in the network" do
      it "returns nil" do
        expect(gaith.spouse).to_not be_present
        expect(gaith.spouse).to be_nil
      end
    end
  end

  describe "#child_in" do
    context "person's parents are registered in network'" do
      it "returns the union in which person is a child (only biological)" do
        expect(nisreen.child_in).to be_a(Union)
        expect(nisreen.child_in.husband).to eq(bassam)
        expect(nisreen.child_in.wife).to eq(dina)
      end
    end

    context "person's parents aren't registered on network" do
      it "returns nil" do
        expect(bassam.child_in).to_not be_present
        expect(bassam.child_in).to be_nil
      end
    end
  end

  describe "#siblings" do
    context "person has siblings from same 2 parents" do
      it "returns an array of the person's siblings" do
        expect(nisreen.siblings).to be_an(Array)
        expect(nisreen.siblings).to all satisfy{ |sibling|
          sibling.father == nisreen.father &&
          sibling.mother == nisreen.mother
        }
        expect(nisreen.siblings).to include(yasmin)
      end
    end

    context "person has no siblings registered in network" do
      it "returns an empty array" do
        expect(gaith.siblings).to_not be_present
        expect(gaith.siblings).to eq([])
      end
    end
  end
end

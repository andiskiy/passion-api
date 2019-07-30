shared_examples 'validates' do |current_model, another_model|
  describe 'Validations' do
    let(:name) { 'Item name' }
    let(:item) { create current_model.to_sym, name: name }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }

    context "when the name is used in #{another_model.capitalize}" do
      let(:valid_item)   { create another_model.to_sym, name: 'New Item name' }
      let(:invalid_item) { create another_model.to_sym, name: name }

      it 'has already been taken' do
        invalid_item
        expect(build(current_model.to_sym, name: name)).not_to be_valid
      end

      it 'name is free' do
        valid_item
        expect(build(current_model.to_sym, name: name)).to be_valid
      end
    end
  end
end

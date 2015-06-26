require 'spec_helper'

describe SideMenuCell, type: :cell do
  context 'cell rendering' do
    let!(:side_menu_cell) { cell(:side_menu) }
    let(:user) { Fabricate(:user_with_calendar_access) }

    context 'rendering show' do
      subject { side_menu_cell }

      before do
        allow(side_menu_cell).to receive(:pundit_user).and_return(user)
        # this sucks. There must be a way to mock a controller for the cell being tested
        allow(side_menu_cell).to receive(:calendars_path).and_return('')
      end

      it 'has an entry for Devices' do
        expect(subject.call(:show)).to include('Devices')
      end

      it 'has an entry for Calendars' do
        expect(subject.call(:show)).to include('Calendars')
      end

      it 'has an entry for Settings' do
        expect(subject.call(:show)).to include('Settings')
      end
    end
  end
end

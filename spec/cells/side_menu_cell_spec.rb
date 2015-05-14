require 'spec_helper'

describe SideMenuCell, type: :cell do

  context 'cell rendering' do
    context 'rendering show' do
      subject { render_cell(:side_menu, :show) }

      it { is_expected.to have_selector('h1', text: 'SideMenu#show') }
      it { is_expected.to have_selector('p', text: 'Find me in app/cells/side_menu/show.html') }
    end
  end

end

module SignInHelper

  def sign_in
    user = create(:user)
    visit root_path

    within '.user-info' do
      click_link 'Sign In'
    end
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    within 'form' do
      click_button 'Sign in'
    end
  end
  
end
module LoginMacros
  def login(user)
    visit new_customer_session_path
    fill_in "customer[email]", with: user.email
    fill_in "customer[password]", with: user.password
    click_button "ログイン"
  end
  def logout
    click_link "ログアウト"
  end
end
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
  
  def login_admin(admin)
    visit new_admin_session_path
    fill_in "admin[email]", with: admin.email
    fill_in "admin[password]", with: admin.password
    click_button "Sig in"
  end
  
  def logout_admin
    click_link "ログアウト"
  end
end

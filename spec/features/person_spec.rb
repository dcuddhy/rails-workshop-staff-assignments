require 'rails_helper'
require 'capybara/rails'

feature 'Person - ' do

  scenario 'Users can see a person show page' do
    create_user email: "user@example.com"
    person = create_person

    visit root_path
    click_on "Login"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name
    within 'h1' do
      expect(page).to have_content(person.full_name)
    end
  end

  scenario 'Users can edit people' do
    create_user email: "user@example.com"
    person = create_person

    visit root_path
    click_on "Login"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name
    within 'h1' do
      expect(page).to have_content(person.full_name)
    end

    click_on 'Edit'
    fill_in 'Title', :with => 'Dr.'
    fill_in 'First name', :with => 'Funken'
    fill_in 'Last name', :with => 'Stein'
    click_on 'Update'

    within '.table' do
      expect(page).to have_content('Dr. Funken Stein')
    end
  end

  scenario 'Users must add title or first name' do
    create_user email: "user@example.com"
    person = create_person

    visit root_path
    click_on "Login"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name
    within 'h1' do
      expect(page).to have_content(person.full_name)
    end

    click_on 'Edit'
    fill_in 'Title', :with => ''
    fill_in 'First name', :with => ''
    fill_in 'Last name', :with => 'Stein'
    click_on 'Update'

    expect(page).to have_content('Title or First Name must be entered')
  end

  scenario 'Users can assign location to people' do
    create_user email: "user@example.com"
    person = create_person
    location = create_location(name: "Northwest")

    visit root_path
    click_on "Login"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"

    click_on person.full_name
    within 'h1' do
      expect(page).to have_content(person.full_name)
    end

    click_on '+Add Location'

    expect(page).to have_content("Assign #{person.full_name} a location")
    select "Northwest", from: "assignment_location"
    fill_in "Role", with: "Boss Man"
    click_on "Assign"
    within '.page-header' do
      expect(page).to have_content(person.full_name)
    end

    within '.table' do
      expect(page).to have_content("Northwest")
      expect(page).to have_content("Boss Man")
    end
  end




end

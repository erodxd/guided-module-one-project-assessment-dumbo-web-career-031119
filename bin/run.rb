require_relative '../config/environment'
require 'figlet'
require 'colorize'
ActiveRecord::Base.logger = nil

system 'clear'

def greet
  puts 'Welcome to Mo\' Money Mo\' Problems, the best resource for US election campaign finance information!'
end

def prompt_instance
  TTY::Prompt.new
end


def exit_method
  puts "Thank you for using Mo'\ Money Mo'\ Problems!"
end

def candidate_list
  prompt = prompt_instance
  prompt.select('Select the candidate') do |q|
    Campaign.all.map do |candidate|
      q.choice "#{candidate.name}"
    end
  end
end

def donor_list
  prompt = prompt_instance
  prompt.select('Select the donor') do |q|
    Donor.all.each do |contributor|
      q.choice "#{contributor.name}"
    end
  end
end



def candidate_total
  system 'clear'
  prompt = prompt_instance
  answer = prompt.select('Select the candidate') do |q|
    Campaign.all.map do |candidate|
      q.choice "#{candidate.name}", candidate.sum_total
    end 
  end
  puts answer
  menu
end


def update_donor_industry(donor)
  system 'clear'
  puts 'What industry would you like to change to'
    user_input = gets.chomp
    donor.update(industry: user_input)
  puts "Successfully changed industry"
  menu
end

def donor_update
  system 'clear'
  prompt = prompt_instance
  input = prompt.select('Who would you like to update?') do |q|
    Donor.all.each do |contributor|
      q.choice "#{contributor.name}", contributor.id
    end 
  end
  donor = Donor.find(input)
  update_donor_industry(donor)
end



def make_donation
  system 'clear'
  # puts "Please select a candidate"
  # user = gets.chomp
  user = candidate_list
  user = Campaign.find_by(name: user)
  if user
    # puts "please enter donor name"
    # user_input = gets.chomp
    user_input = donor_list
    donor = Donor.find_by(name: user_input)
    puts "How much would you like to donate"
    input = gets.chomp
    Donation.create(amount: input, donor_id: donor.id, campaign_id: user.id)
    puts "Donation accepted. Thank you!"
    menu
  else puts "Please try again"
    menu
  end
end

def delete_donation
  #puts "Which donor's contributions would you like to return?"
  #donor_name = gets.chomp
  donor_name = donor_list
  selected_donor = Donor.all.find_by(name: donor_name)
  contribution = Donation.find_by(donor_id: selected_donor.id).destroy
  puts "Successfully returned contributions."
  menu
end

def menu
  prompt = prompt_instance
  prompt.select('What would you like to do today?') do |q|
    q.choice 'Review campaign donations', -> {candidate_total}
    q.choice 'Update donor industry', -> {donor_update}
    q.choice 'Make a donation', -> {make_donation}
    q.choice 'Return a donation', -> {delete_donation}
    q.choice 'Exit', -> {exit_method}
  end
end

greet
sleep(1)
menu
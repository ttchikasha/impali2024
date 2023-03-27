# == Route Map
#

Rails.application.routes.draw do
  get "learning_areas/index"
  post "pardon_students/pardon", format: :json
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :contact_messages, except: %i[edit destroy], path: "site-messages"
  resources :online_applications
  resources :schedules
  authenticate :user do
    resources :student_attendances
    resources :students do
      collection do 
        get :results
      end
    end
    resources :school_payments, only: %i[edit update]
    resources :assignments, except: :index do
      resources :questions
    end
    # resources :private_threads do
    #   resources :messages, only: :create
    # end
    resources :reports
    resource :dashboard, only: :show
    resources :teacher
    resources :student
    resources :classroom_subjects, except: :index do
      resources :topics
      resources :assignments
    end
    resources :assignments, except: :index do
      resources :assignment_answers, only: %i[update index show create] do
        member do
          put :mark
        end
      end
    end
    resources :topics do
      resources :lessons
    end
    resources :question_answers, only: :update
    resources :questions do
      resources :question_answers
    end
    resources :classrooms, except: %i[destroy new] do
      # resources :messages, only: :create
      member do
        get :chat_room
      end
    end
    resources :subjects
    # resources :messages, only: :index
    resources :payments, except: [:edit]
    resources :notifications, path: "notices"
    resources :users do
      resources :results
      resources :student_parents
      resources :student_payments, only: %i[new create] do
        collection { patch :update_owing }
      end
      collection do
        get :profile
        get :teachers_autocomplete
        get :staff_autocomplete, format: :json
      end
    end
  end

  devise_for :users, path: "auth", controllers: {
                       registrations: "users/registrations",
                     }
  root "home#index"

  get "/staff", to: "home#staff"
  get "/learning-areas", to: "learning_areas#index"
  get "/apply-online", to: "home#online_application"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

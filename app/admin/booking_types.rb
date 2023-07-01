ActiveAdmin.register BookingType do
  includes :bookings
  permit_params :name, :location, :color, :payement_required, :price, :user_id, :start_date, :end_date

   

    filter :name, as: :select, collection: proc {BookingType.pluck(:name)}
    filter :price, as: :numeric_range_filter
    filter :user_id, as: :search_select_filter, url: proc { admin_users_path },
                      fields: %i[first_name last_name], method_model: User, display_name: 'first_name', minimum_input_length: 2
    filter :payment_required 
    filter :start_date, as: :date_time_picker_filter
    filter :end_date, as: :date_time_picker_filter
    filter :location

    member_action :save, method: [:post] do
     ActiveAdmin::DynamicFields.update(resource, params)
    end
     
    index do
      selectable_column
      toggle_bool_column :payement_required, success_message: 'Payement status updated'
      column "Name" do |type|
        div type.name, ActiveAdmin::DynamicFields.edit_string(:name, save_admin_booking_type_path(type.id))
      end
      column "Location" do |type|
        div type.location, ActiveAdmin::DynamicFields.edit_string(:location, save_admin_booking_type_path(type.id))
      end
      column "Price" do |type|
        number_to_currency(type.price)
      end
      column :user
      column ":start_date" do |type|
        div type.start_date, ActiveAdmin::DynamicFields.edit_string(:start_date, save_admin_booking_type_path(type.id))
      end
      column :end_date
      actions
    end
end
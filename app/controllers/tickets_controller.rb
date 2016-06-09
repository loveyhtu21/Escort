class TicketsController < ApplicationController
	
	def index
		@tickets=Ticket.all
	end

	def create
		@user=User.find_by_id(params[:user_id])
		if @user
			@ticket=Ticket.create(:title=>params[:ticket][:title],:content=>params[:ticket][:content],:user_id=>@user.id,:status=>false)
			flash[:notice]="ticket created successfully"
      redirect_to	user_ticket_path(@user.id,@ticket.id)

			#redirect_to user_ticket_path(encrypt(@user.id),encrypt(@ticket.id))
		else
			flash[:notice]="ticket not generated"
      render 'new'
		end

	end
	
	def new
	end
	def show 
		#@user=User.find_by_id(decrypt(params[:user_id]))
		@user=User.find_by_id(params[:user_id])
		@ticket=Ticket.find_by_id(params[:id])
		@comments=@ticket.ticket_comments.order(created_at: "ASC")
		p"--------#{@comments.count}"
	end

	def edit
		@user=User.find_by_id(params[:user_id])
		@ticket=Ticket.find_by_id(params[:id])
	end
	def update
		@user=User.find_by_id(params[:user_id])
		@ticket=Ticket.find_by_id(params[:id])
		if @ticket
			@ticket.update_attributes(:title=>params[:ticket][:title],:content=>params[:ticket][:content])
			flash[:notice]="ticket updated successfully"
			redirect_to	user_ticket_path(@user.id,@ticket.id)
		else
			 redirect_to edit_user_ticket_path(current_business_user,@ticket.id)
		end
	end
end
class SearchesController < ApplicationController
  before_action :authenticate_user!

   def search
    @range = params[:range]

      if @range == "User"
        @users = User.looks(params[:search], params[:word])
      else
        @books = Book.looks(params[:search], params[:word])
        
      end
   end
end
# 前方一致
#モデル名.where("カラム名 LIKE ?", "値%")
# 後方一致
#モデル名.where("カラム名 LIKE ?", "%値")
# 部分一致
#モデル名.where("カラム名 LIKE ?", "%値%")

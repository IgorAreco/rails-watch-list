class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    # como o restaurante nao eh um campo no form, mas sim uma info que esta
    # na url, devemos pega-lo do mesmo jeito que fizemos no #new
    @list = List.find(params[:list_id])

    @bookmark = Bookmark.new(bookmark_params)

    # depois de criarmos a bookmark com as infos que o user preencheu no form,
    # precisamos conecta-la alist que pegamos da url
    @bookmark.list = @list

    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list)
  end

  def bookmark_params
    # repare que o :restaurant_id nao esta presente aqui. Nao queremos que
    # o user nos passe essa informacao (pois pegaremos ela da url)
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end

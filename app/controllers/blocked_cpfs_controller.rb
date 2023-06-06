class BlockedCpfsController < ApplicationController
  def index
    @cpfs = BlockedCpf.all
  end

  def new
    @blocked_cpf = BlockedCpf.new()
  end

  def create
    blocked_cpf_params = params.require(:blocked_cpf).permit(:cpf, :reason)
    @blocked_cpf = BlockedCpf.new(cpf: blocked_cpf_params[:cpf], reason: blocked_cpf_params[:reason],
      blocked_by: current_user)
    if @blocked_cpf.save()
      redirect_to blocked_cpfs_path, notice: 'CPF bloqueado com sucesso'
    else
      flash.now[:notice] = 'CPF não foi bloqueado'
      render 'new'
    end
  end
end
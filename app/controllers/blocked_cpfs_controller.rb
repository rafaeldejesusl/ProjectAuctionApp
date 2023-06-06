class BlockedCpfsController < ApplicationController
  def index
    @cpfs = BlockedCpf.all
  end
end
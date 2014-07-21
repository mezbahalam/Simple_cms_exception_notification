class DemoController < ApplicationController
  layout 'demo'
  def index
    render text: `ps -axcr -o 'pid,pcpu,pmem,time,comm'`
  end

  def list
    render text: `ps -axcr -o 'pid,pcpu,pmem,time,comm'`
  end

  def text_helpers
  end
end

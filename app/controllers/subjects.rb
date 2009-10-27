class Subjects < Application
   provides :rdf, :json, :nt, :rss, :atom
   before :machine_only, :only => [:update]
   
  require 'platform_client'
  def index
    @store = PlatformClient.create
    opts = {:max=>50,'offset'=>(params['offset']||0),:sort=>'preflabel'}
    @results = @store.search('*:*', opts)
    @title = 'All LCSH'
    display @results
  end

  def show(id)
    @store = PlatformClient.create
    unless id =~ /#concept$/
      id << "#concept"
    end
    @authority, @collection = @store.describe_by_id(id, set_mime_type(content_type))
    raise NotFound if @authority.nil?
    @store.construct_related_preflabels(@authority.uri, @collection)
    @title = @authority.skos['prefLabel']
    display @authority
  end

#  def new
#    only_provides :html
#    @authority = Authority.new
#    display @authority
#  end

#  def edit(id)
#    only_provides :html
#    @authority = Authority.get(id)
#    raise NotFound unless @authority
#    display @authority
#  end

#  def create(authority)
#    @authority = Authority.new(authority)
#    if @authority.save
#      redirect resource(@authority), :message => {:notice => "Authority was successfully created"}
#    else
#      message[:error] = "Authority failed to be created"
#      render :new
#    end
#  end

#  def update(id, rdf)
#    #only_provides :nt
#    @store = PlatformClient.create
#    response = @store.describe_by_id("#{id}#concept")
#    raise NotFound if response.status == 404
#    @authority = Subject.new_from_platform(response)
#    raise NotFound unless @authority
    #if @authority.update_attributes(authority)
    #   redirect resource(@authority)
    #else
#    render(rdf, :format=>:nt)
    #end
#  end

#  def destroy(id)
#    @authority = Authority.get(id)
#    raise NotFound unless @authority
#    if @authority.destroy
#      redirect resource(:authorities)
#    else
#      raise InternalServerError
#    end
#  end
  
  def search
    @results = nil
    @title = 'Search LCSubjects.org'
    if params['q']
      opts = {}
      opts['max'] = params['max']||25
      opts['offset'] = params['offset']||0
      if params['sort']
        opts['sort'] = params['sort']
      end
      @store = PlatformClient.create
      @results, @collection = @store.search(params['q'], opts)
      @title << ": #{params['q']}"
    end
    display @results   
  end
  
  private
  def machine_only
    ensure_authenticated Merb::Authentication::Strategies::Basic::OpenID
  end
  

end # Authorities

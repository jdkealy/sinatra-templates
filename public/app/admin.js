App.Admin = {};

App.Admin.ResourceView = Backbone.View.extend({

  template:JST['underscore/admin/resource'],

  initialize: function(){
    _.bindAll(this,'render','addOne');
    this.collection.bind('reset', this.render);
  },

  render: function(){
    $(this.el).html(this.template());
    this.$('.resource_name').html(this.options.resource.get('class_name'));
    var thead = [];
    if(this.options.resource.get('crud_attributes')){
      _.each(this.options.resource.get('crud_attributes'), function(cf){
        thead.push('<th>');
        thead.push(cf);
        thead.push('</th>');
      });
      this.$('thead').html(thead.join(''));
    }
    this.collection.each(this.addOne);
    return this;
  },

  addOne: function(model){
    var view = new App.Admin.ResourceItemView({model:model, resource:this.options.resource});
    $(this.el).find('tbody').append(view.render().el);
    return this;
  }

});

App.Admin.ResourceItemView = Backbone.View.extend({

  tagName:'tr',

  initialize: function(){
    _.bindAll(this,'render');
  },

  render: function(){
    var cmp   = this;
    var thead = [];
    if(this.options.resource.get('crud_attributes')){
      _.each(this.options.resource.get('crud_attributes'), function(cf){
        thead.push('<td>');
        thead.push(cmp.model.get(cf));
        thead.push('</td>');
      });
      $(this.el).html(thead.join(''));
    }

    return this;
  }

});

App.Admin.Router = Backbone.Router.extend({

  routes: {
    "":"testing",
    "resources/:id":                  "navigateToResource"
  },

  testing:function(){
  },

  navigateToResource: function(id){
    var collection      = new Backbone.Collection();
        collection.url  = '/restapi/' + id;
        collection.fetch();
    if(App.rest_sources){
      var resource = _.filter(App.rest_sources.models,function(rs){ return rs.get('class_name')===id; })[0];
      var resource_view = new App.Admin.ResourceView({resource:resource, collection:collection});
      $('#admin_resource').html(resource_view.el);
    }
  }

});

App.app_router = new App.Admin.Router();

Backbone.history.start();


App.Admin.Router = Backbone.Router.extend({

});
App.RestSource = Backbone.Model.extend({

});

App.RestSources = Backbone.Collection.extend({
  url:'/admin/resources',
  model:App.RestSource
});

App.Admin.Navigation = Backbone.View.extend({
  initialize:function(){
    _.bindAll(this,'render','addOne');
    this.collection.bind('reset', this.render);
  },

  tagName:'ul',

  render: function(){
    this.collection.each(this.addOne);
    return this;
  },

  addOne: function(model){
    var view = new App.Admin.NavigationItem({model:model});
    $(this.el).append(view.render().el);
    return this;
  }

});

App.Admin.NavigationItem = Backbone.View.extend({

  initialize:function(){
    _.bindAll(this,'render');
    this.model.bind('change', this.render);
  },

  events: {
    'click':'navigateToResource'
  },

  navigateToResource: function(){
    App.app_router.navigate('/resources/' + this.model.get('class_name'), {trigger:true});
    return false;
  },

  tagName:'li',
  render: function(){
    $(this.el).html(this.model.get('class_name') + "<div>HI THERE</div>");
    return this;
  }
});

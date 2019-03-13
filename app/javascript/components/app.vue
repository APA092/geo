<template>
  <div id="app">
    
    <h1 class="title">Optimum.global</h1>
    <h2 class="subtitle">Optimal Geo Routes</h2>
      
    <div v-if="locations.length > 19">
      <div class="notification is-warning">
        Location's limit reached
      </div>
    </div>
          
    <div v-if="locations.length < 20"> 
      <div class="field has-addons">
        <input class="input" type="text" v-model="request" placeholder="Type location">
        <button id="btn" class="button is-primary" v-on:click="getLocation()">Add location</button>
      </div>
    </div>
          
    <div v-for="(location, index) in locations">
      {{location.name}}
      <button class="button is-info" v-on:click="request = location.initial, locations.splice(index, 1)">Edit</button>
      <button class="button is-danger" v-on:click="locations.splice(index, 1)">Remove</button>
    </div>
    
    <div v-if="locations.length > 3">
      <button id="btn" class="button is-primary" v-on:click="getLocation()">Calculate optimal route</button>
    </div>
    
    <HereMap appId="sT4evJ6zERUorlOM0NMU" 
    appCode="ZoLn3Vjmf4jFUe-kQ3t6xQ" 
    lat = "24"
    lng = "10"
    width="100%" 
    height="835px" />
  </div>
</template>

<script>
  import HereMap from "./HereMap.vue"
  export default {
    name: 'app',
      data () {
        return {
          request: null,
          locations: [],
          loading: false,
        }
      }, 
      components: {
            HereMap
        },
      methods: {
         getLocation: function () {
          this.loading = true;
          axios.post("/", {address: this.request})
          .then((response)  =>  {
            this.loading = false;
            this.locations.push({initial: this.request, name: response.data.Response.View[0].Result[0].Location.Address.Label});
            this.request = null;
          }, (error)  =>  {
            this.loading = false;
          })
        }
      },
  }
</script>

<style>
    #app {
        font-family: 'Avenir', Helvetica, Arial, sans-serif;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        text-align: center;
        color: #2c3e50;
    }
</style>
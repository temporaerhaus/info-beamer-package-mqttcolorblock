var config = {
  props: ['config'],
  template: `
    <div>
      <h4>MQTT Color Block</h4>
      <div class='row'>
        <div class='col-xs-3'>
          <label class="field-label">MQTT Topic</label>
          <input type="text" v-model="mqtt_topic" placeholder="blocks/info/color" />
        </div>
      </div>
    </div>
  `,
  computed: {
    mqtt_topic: ChildTile.config_value('mqtt_topic', ''),
  }
}

ChildTile.register({
  config: config,
});

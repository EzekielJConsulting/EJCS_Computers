import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
	state: {
		playerData: {},
	},
	getters: {
		playerData(state) {
			return state.playerData;
		},
	},
	mutations: {
		setplayerData(state, payload) {
			state.playerData = payload.data;
		},
	},
	actions: {},
});

<template>
   <div class="screen h-full relative" :class="{ 'dark': darkMode, 'night-light': nightLight }">

        <router-view/>

        <div class="bootloader absolute left-0 top-0 w-full h-full bg-black flex flex-col justify-center items-center w-full h-full overflow-hidden z-50" v-if="isLoading">
            <img src="@/assets/boot-logo.png" width="180" class="mb-48"/>
            <Loader/>
        </div>

    </div>
    
</template>

<script>
import Loader from './components/Loader'
import { mapMutations } from "vuex";
export default {
    name: 'App',
    data: () => ({
		isVisible: false,
	}),
    components: {
        Loader
    },
    
    computed: {
        darkMode() {
            return this.$store.state.darkMode
        },
        nightLight() {
            return this.$store.state.nightLight
        },
        isLoading() {
            return this.$store.state.loading
        }
    },
    methods: {
		...mapMutations(["setPlayerID"]),
        toggleShow() {
			this.isVisible = !this.isVisible;
		},
		
	},
    mounted() {
        window.addEventListener('load', () => {
            setTimeout(() => {
                this.$store.dispatch('hideBootScreen')
            }, 2000)
        }),
        this.listener = window.addEventListener("message", (e) => {
			const item = e.data || e.detail;
			if (this[item.type]) this[item.type](item);
		});
    },
	destroyed() {
		window.removeEventListener("message", this.listener);
	},
}
</script>

<style lang="scss">

html, body {
    // height: 100%;
    height: 683px;
    width: 1214px;
    overflow:hidden;
}

* {
    -webkit-user-drag: none;
    -khtml-user-drag: none;
    -moz-user-drag: none;
    -o-user-drag: none;
    user-drag: none;

    -webkit-touch-callout: none;
    -webkit-user-select: none;
    -khtml-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

#app {
    // height: 749px;
    // width: 1062px;
    height: 100%;
}


.screen::after {
    content: '';
    background: rgba(255, 0, 0, 0.15);
    opacity: 0;
    position: absolute;
    left: 0;
    top: 0;
    right: 0;
    bottom: 0;
    z-index: 999999;
    pointer-events: none;
    transition: 2s;
}

.screen.night-light::after {
    opacity: 1;
}

.bootloader {
    cursor: none;
}

</style>


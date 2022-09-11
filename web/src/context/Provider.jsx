import { createContext, useContext, useState } from "react";
import { useNuiEvent } from "fivem-nui-react-lib";

const resource = 'ECJS_Computers'

const Context = createContext(undefined)

export const ContextProvider = ({children}) => {
    const [visible, setVisible] = useState(false)
    
    useNuiEvent(resource, 'toggleVisibility', setVisible)

    /* Both options could be used
        useNuiEvent('RESOURCENAME', 'toggleVisibility', (data) => {
            setVisible(data)
        })
        useNuiEvent('RESOURCENAME', 'toggleVisibility', setVisible)
    */

    const value = {
        visible, 
        setVisible,
    }

    return <Context.Provider value={value}>{children}</Context.Provider>
}

export const useVisible = () => {
    const { visible, setVisible } = useContext(Context)
    return { visible, setVisible }
}
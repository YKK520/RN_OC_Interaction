import React, { Component } from 'react';
import {
    StyleSheet,
    Text,
    View,
    NativeModules,
} from 'react-native';

var RNManager = NativeModules.RNManager;

export default  class  FFHomePage extends  Component{
    constructor(props){
        super(props);
        this.state = {
            cache:0,
        }
    }
    render(){
        return(
            <View>
                <Text
                    style={styles.txt}
                    onPress={()=>this.passToNativeWithStr()}>RN-->Native Str</Text>
                <Text
                    style={styles.txt}
                    onPress={()=>this.passToNativewithDic()}>RN-->Native Str+Dic</Text>
                <Text
                    style={styles.txt}
                    onPress={()=>this.passToNativeWithStrAndDate()}>RN-->Native Str+Date</Text>
                <Text
                    style={styles.txt}
                    onPress={()=>this.passToNativeWithStrAndCallBack()}>点击调原生+回调</Text>
                <Text
                    style={styles.txt}
                    onPress={()=>this.promiseRNCallBack()}>Promises</Text>
                <Text
                    style={styles.txt}
                    onPress={()=>this.showNativeValue()}>使用原生定义的常量</Text>
                <Text
                    style={styles.txt}
                >
                    { '缓存'+this.state.cache+'M'} </Text>
                <Text
                    style={styles.txt}
                    onPress={()=>this.showCleanCache()}>'清理缓存'</Text>
            </View>
        );
    }
    // 传原生一个字符串
    passToNativeWithStr = ()=>{
        RNManager.passStr('千夜');
    }
    // 传原生一个字符串 + 字典
    passToNativewithDic = ()=> {
        RNManager.passDic('千夜', {key: '0千夜0'});
    }
    // 传原生一个字符串 + 日期
    passToNativeWithStrAndDate = ()=>{
        RNManager.passStrAndDate('千夜',19910730);
    }
    // 传原生一个字符串 + 回调
    passToNativeWithStrAndCallBack = ()=>{
        RNManager.passStrCallBack(('RN给原生的'),(error, events) => {
            if (error) {
                console.error(error);
            } else {
                alert(events)
            }
        })
    }
   //Promise回调
    async promiseRNCallBack(){
        try{
            var events=await RNManager.promiseNativeCallBack();
            alert(events)
        }catch(e){
            console.error(e);
        }
    }
    //使用原生定义的常量
    showNativeValue = ()=>{
        alert(RNManager.value)
    }

    //计算 缓存 再进入清除缓存界面时,就计算缓存大小
    componentWillMount (){
        RNManager.calculateCacheSize((error,block)=>{
            if (error)
            {
                console.error(error);
            }
            else
            {
                this.setState({
                    cache:Math.round(block/1024)   //缓存大小
                })
            }

        })
    }
    //清理缓存
    showCleanCache(){
        RNManager.cleanCache((error,block)=>{
            if (error)
            {
                console.error(error);
            }
            else
            {
                this.setState({
                    cache:0  //Math.round(events/1024)总是清不干净,我就直接置为0
                })
            }
        })
    }

}
const styles = StyleSheet.create({
    container:
        {
            flex: 1,
            marginTop:100
        },
    txt:
        {
            fontSize: 20,
            textAlign: 'center',
            margin: 20,

        },
});
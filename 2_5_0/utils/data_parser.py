# -*- coding: UTF-8 -*-
"""
This module contains functions that are only used in data2ld.py
"""
from lxml import etree

def DvBoolean(data):
    ret_str = '{\n'
    parent = data.tag.replace('{http://www.mlhim.org/ns/mlhim2/}','')
    ret_str += '"@id":' + '"' + parent + '",\n'
    ret_str += '"@type":' + '"' + parent.replace('pcs-','pcm-') + '"},\n'
    children = data.getchildren()
    for child in children:
        if 'pcs-' not in child.tag:
            ret_str += '{\n"@id":' + '"' + parent + '/'+child.tag + '",\n'
            if child.text != None:
                ret_str += '"@value":"'+child.text+'"\n'
            else:
                ret_str += '"@value":""\n'

            ret_str += '},\n'
    return(ret_str + '\n')

def DvLink(data):
    ret_str = '{\n'
    parent = data.tag.replace('{http://www.mlhim.org/ns/mlhim2/}','')
    ret_str += '"@id":' + '"' + parent + '",\n'
    ret_str += '"@type":' + '"' + parent.replace('pcs-','pcm-') + '"},\n'
    children = data.getchildren()
    for child in children:
        if 'pcs-' not in child.tag:
            ret_str += '{\n"@id":' + '"' + parent + '/'+child.tag + '",\n'
            if child.text != None:
                ret_str += '"@value":"'+child.text+'"\n'
            else:
                ret_str += '"@value":""\n'

            ret_str += '},\n'
    return(ret_str + '\n')


def DvString(data):
    ret_str = '{\n'
    parent = data.tag.replace('{http://www.mlhim.org/ns/mlhim2/}','')
    ret_str += '"@id":' + '"' + parent + '",\n'
    ret_str += '"@type":' + '"' + parent.replace('pcs-','pcm-') + '"},\n'
    children = data.getchildren()
    for child in children:
        if 'pcs-' not in child.tag:
            ret_str += '{\n"@id":' + '"' + parent + '/'+child.tag + '",\n'
            if child.text != None:
                ret_str += '"@value":"'+child.text+'"\n'
            else:
                ret_str += '"@value":""\n'

            ret_str += '},\n'
    return(ret_str + '\n')

def DvOrdinal(data):
    ret_str = '{\n'
    parent = data.tag.replace('{http://www.mlhim.org/ns/mlhim2/}','')
    ret_str += '"@id":' + '"' + parent + '",\n'
    ret_str += '"@type":' + '"' + parent.replace('pcs-','pcm-') + '"},\n'
    children = data.getchildren()
    for child in children:
        if 'pcs-' not in child.tag:
            ret_str += '{\n"@id":' + '"' + parent + '/'+child.tag + '",\n'
            if child.text != None:
                ret_str += '"@value":"'+child.text+'"\n'
            else:
                ret_str += '"@value":""\n'

            ret_str += '},\n'
    return(ret_str + '\n')

def DvTemporal(data):
    ret_str = '{\n'
    parent = data.tag.replace('{http://www.mlhim.org/ns/mlhim2/}','')
    ret_str += '"@id":' + '"' + parent + '",\n'
    ret_str += '"@type":' + '"' + parent.replace('pcs-','pcm-') + '"},\n'
    children = data.getchildren()
    for child in children:
        if 'pcs-' not in child.tag:
            ret_str += '{\n"@id":' + '"' + parent + '/'+child.tag + '",\n'
            if child.text != None:
                ret_str += '"@value":"'+child.text+'"\n'
            else:
                ret_str += '"@value":""\n'

            ret_str += '},\n'
    return(ret_str + '\n')

def DvCount(data):
    ret_str = ''
    parent = data.tag.replace('{http://www.mlhim.org/ns/mlhim2/}','')
    ret_str += '{\n"@id":' + '"' + parent + '",\n'
    ret_str += '"@type":' + '"' + parent.replace('pcs-','pcm-') + '"},\n'
    children = data.getchildren()
    for child in children:
        if 'pcs-' not in child.tag:
            if child.tag == 'dvcount-units':
                ret_str += '{\n"@id":' + '"' + parent + '/'+child.tag + '/label",\n'
                ret_str += '"@value":"'+child[0].text+'"\n},\n'

            else:
                ret_str += '{\n"@id":' + '"' + parent + '/'+child.tag + '",\n'
                if child.text != None:
                    ret_str += '"@value":"'+child.text+'"\n},\n'
                else:
                    ret_str += '"@value":""\n},\n'

            ret_str += ''
    return(ret_str + '\n')

